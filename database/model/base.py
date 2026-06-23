from sqlalchemy.ext.declarative import declarative_base
from sqlalchemy import inspect

class BaseMixin:
    def to_dict(self):
        return {c.key: getattr(self, c.key) for c in inspect(self).mapper.column_attrs}

Base = declarative_base(cls=BaseMixin)
