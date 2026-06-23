from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class Inventory(Base):
    __tablename__ = 'inventory'

    character_id = Column(Text, nullable=False, primary_key=True)
    item_id = Column(Text, nullable=False, primary_key=True)
    quantity = Column(Integer)
