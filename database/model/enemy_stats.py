from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class EnemyStats(Base):
    __tablename__ = 'enemy_stats'

    enemy_id = Column(Text, nullable=False, primary_key=True)
    strength = Column(Integer)
    speed = Column(Integer)
    mana = Column(Integer)
    energy = Column(Integer)
    hp = Column(Integer)
    luck = Column(Integer)
