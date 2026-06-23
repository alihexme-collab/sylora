from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class Item(Base):
    __tablename__ = 'item'

    item_id = Column(Text, nullable=False, primary_key=True)
    name = Column(Text)
    rarity = Column(Text)
    type = Column(Text)
    description = Column(Text)
    effect_json = Column(JSON)
    rarity_weight = Column(Integer)
