from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class BattleLog(Base):
    __tablename__ = 'battle_log'

    battle_id = Column(Text, nullable=False, primary_key=True)
    character_id = Column(Text)
    enemy_id = Column(Text)
    result = Column(Text)
    reward_json = Column(JSON)
    created_at = Column(DateTime)
    enemy_power = Column(Integer)
    enemy_type = Column(Text)
