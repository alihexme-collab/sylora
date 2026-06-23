from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class Equipment(Base):
    __tablename__ = 'equipment'

    equipment_id = Column(Text, nullable=False, primary_key=True)
    item_id = Column(Text, nullable=False)
    character_id = Column(Text, nullable=False)
    slot_type = Column(Text, nullable=False)
    enhancement_level = Column(Integer, nullable=False, default=0)
    durability = Column(Integer)
    max_durability = Column(Integer)
    equipped_at = Column(DateTime, nullable=False, server_default=func.now())
    unequipped_at = Column(DateTime)
    is_equipped = Column(Boolean, nullable=False, default=True)
    extra_json = Column(JSON)
