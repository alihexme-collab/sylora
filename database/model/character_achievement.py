from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class CharacterAchievement(Base):
    __tablename__ = 'character_achievement'

    character_id = Column(Text, nullable=False, primary_key=True)
    achievement_id = Column(Text, nullable=False, primary_key=True)
    progress = Column(Integer, nullable=False, default=0)
    target_value = Column(Integer)
    unlocked_at = Column(DateTime)
    claimed_at = Column(DateTime)
    status = Column(Text, nullable=False, default='locked')
    metadata_json = Column(JSON)
