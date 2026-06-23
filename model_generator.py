import re
import os

# --- Configurations ---
SQL_FILE_PATH = 'sylora.sql'
OUTPUT_DIR = 'model'

TYPE_MAP = {
    'bigint': 'BigInteger', 'boolean': 'Boolean', 'date': 'Date',
    'double precision': 'Float', 'integer': 'Integer', 'json': 'JSON',
    'jsonb': 'JSON', 'numeric': 'Numeric', 'text': 'Text',
    'varchar': 'String', 'character varying': 'String',
    'timestamp': 'DateTime', 'timestamp with time zone': 'DateTime(timezone=True)',
    'uuid': 'String',
}

def clean_sql_value(val):
    """پاکسازی مقادیر پیش‌فرض SQL و تبدیل به معادل پایتونی"""
    if not val: return None
    val = val.split('::')[0]  # حذف ::text و موارد مشابه
    val = val.strip("'\" ")
    
    if val.lower() == 'now()': return 'func.now()'
    if val.lower() == 'false': return 'False'
    if val.lower() == 'true': return 'True'
    if val.isdigit(): return val
    return f"'{val}'"

def parse_sql_to_dict(sql_content):
    """تحلیل کل فایل SQL برای استخراج جداول و روابط"""
    tables = {}
    # پیدا کردن بلوک‌های CREATE TABLE
    table_matches = re.findall(r'CREATE TABLE(?:\s+IF NOT EXISTS)?\s+([\w\.]+)\s*\((.*?)\);', sql_content, re.S | re.I)
    
    for full_name, body in table_matches:
        t_name = full_name.split('.')[-1].strip('"')
        tables[t_name] = {'columns': [], 'fks': []}
        
        lines = [line.strip() for line in body.strip().split('\n')]
        for line in lines:
            line = line.rstrip(',')
            # تشخیص Foreign Key های داخل خطی یا انتهای جدول
            fk_match = re.search(r'FOREIGN KEY\s*\((.*?)\)\s*REFERENCES\s+([\w\.]+)\s*\((.*?)\)', line, re.I)
            if fk_match:
                tables[t_name]['fks'].append({
                    'local': fk_match.group(1).strip('" '),
                    'ref_table': fk_match.group(2).split('.')[-1].strip('" '),
                    'ref_col': fk_match.group(3).strip('" ')
                })
                continue
            
            if line.upper().startswith(('CONSTRAINT', 'PRIMARY KEY', 'UNIQUE')): continue
            
            # تحلیل ستون
            parts = line.split()
            if len(parts) < 2: continue
            
            c_name = parts[0].strip('"')
            # تشخیص تایپ‌های چند کلمه‌ای مثل timestamp with time zone
            type_part = " ".join(parts[1:])
            sa_type = 'Text'
            for sql_t, sa_t in TYPE_MAP.items():
                if sql_t in type_part.lower():
                    sa_type = sa_t
                    break
            
            col_data = {
                'name': c_name, 'type': sa_type,
                'pk': 'PRIMARY KEY' in line.upper(),
                'unique': 'UNIQUE' in line.upper(),
                'nullable': 'NOT NULL' not in line.upper(),
                'default': None
            }
            
            def_match = re.search(r'DEFAULT\s+([^,\s]+)', line, re.I)
            if def_match:
                col_data['default'] = clean_sql_value(def_match.group(1))
            
            tables[t_name]['columns'].append(col_data)
            
    return tables

def generate_files(tables_dict):
    if not os.path.exists(OUTPUT_DIR): os.makedirs(OUTPUT_DIR)
    
    # 1. Base.py
    with open(os.path.join(OUTPUT_DIR, 'base.py'), 'w') as f:
        f.write("from sqlalchemy.ext.declarative import declarative_base\n")
        f.write("from sqlalchemy import inspect\n\n")
        f.write("class BaseMixin:\n    def to_dict(self):\n")
        f.write("        return {c.key: getattr(self, c.key) for c in inspect(self).mapper.column_attrs}\n\n")
        f.write("Base = declarative_base(cls=BaseMixin)\n")

    model_registry = []

    # 2. Individual Models
    for t_name, data in tables_dict.items():
        class_name = ''.join(w.capitalize() for w in t_name.split('_'))
        model_registry.append((t_name, class_name))
        
        with open(os.path.join(OUTPUT_DIR, f"{t_name}.py"), 'w') as f:
            f.write("from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric\n")
            f.write("from sqlalchemy.orm import relationship\n")
            f.write("from .base import Base\n\n")
            f.write(f"class {class_name}(Base):\n")
            f.write(f"    __tablename__ = '{t_name}'\n\n")
            
            for col in data['columns']:
                args = [col['type']]
                # چک کردن اگر ستون FK است
                for fk in data['fks']:
                    if fk['local'] == col['name']:
                        args.append(f"ForeignKey('{fk['ref_table']}.{fk['ref_col']}')")
                
                if col['pk']: args.append("primary_key=True")
                if not col['nullable']: args.append("nullable=False")
                if col['unique']: args.append("unique=True")
                if col['default']:
                    key = "server_default" if "func" in col['default'] else "default"
                    args.append(f"{key}={col['default']}")
                
                f.write(f"    {col['name']} = Column({', '.join(args)})\n")
            
            # اضافه کردن Relationship های پایه (اختیاری)
            for fk in data['fks']:
                ref_class = ''.join(w.capitalize() for w in fk['ref_table'].split('_'))
                f.write(f"    {fk['ref_table']} = relationship('{ref_class}')\n")

    # 3. __init__.py
    with open(os.path.join(OUTPUT_DIR, '__init__.py'), 'w') as f:
        f.write("from .base import Base\n")
        for t, c in model_registry:
            f.write(f"from .{t} import {c}\n")

if __name__ == "__main__":
    with open(SQL_FILE_PATH, 'r', encoding='utf-8') as f:
        content = f.read()
    data = parse_sql_to_dict(content)
    generate_files(data)
    print("✨ Professional models generated with relationships and cleaned defaults!")
