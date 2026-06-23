from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class Enemy(Base):
    __tablename__ = 'enemy'

    enemy_id = Column(Text, nullable=False, primary_key=True)
    type = Column(Text)
    name = Column(Text)
    rank_id = Column(Text)
    loot_json = Column(JSON)
    location_id = Column(Text)
    description = Column(Text)
    rarity_weight = Column(Integer)
    origin_world = Column(Text)
