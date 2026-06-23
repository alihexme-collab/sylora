from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class CharacterStats(Base):
    __tablename__ = 'character_stats'

    defense = Column(Integer)
    strength = Column(Integer)
    speed = Column(Integer)
    mana = Column(Integer)
    energy = Column(Integer)
    level = Column(Integer)
    exp = Column(Integer)
    gold = Column(BigInteger)
    hp = Column(Integer)
    hunting_points = Column(Integer)
    black_knowledge_level = Column(Integer)
    intelligence = Column(Integer)
    luck = Column(Integer)
    character_id = Column(Text, nullable=False, primary_key=True)
