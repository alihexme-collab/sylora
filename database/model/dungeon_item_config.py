from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class DungeonItemConfig(Base):
    __tablename__ = 'dungeon_item_config'

    dungeon_id = Column(Text, nullable=False, primary_key=True)
    item_id = Column(Text, nullable=False, primary_key=True)
    min_count = Column(Integer)
    max_count = Column(Integer)
    dnx_weight = Column(Integer)
