from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class Race(Base):
    __tablename__ = 'race'

    race_id = Column(Text, nullable=False, primary_key=True)
    name = Column(Text)
    talent_modifiers = Column(JSON)
    description = Column(Text)
    spawn_weight = Column(Integer)
    civilization_id = Column(Integer)
    base_stats_modifier = Column(JSON)
