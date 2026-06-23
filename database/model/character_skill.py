from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class CharacterSkill(Base):
    __tablename__ = 'character_skill'

    character_id = Column(Text, nullable=False, primary_key=True)
    skill_id = Column(Text, nullable=False, primary_key=True)
    level = Column(Integer)
    unlocked_at = Column(DateTime)
    discovery_method = Column(Text)
