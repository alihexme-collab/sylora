from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class CharacterQuest(Base):
    __tablename__ = 'character_quest'

    character_id = Column(Text, nullable=False, primary_key=True)
    quest_id = Column(Text, nullable=False, primary_key=True)
    status = Column(Text)
    progress = Column(Text)
    updated_at = Column(DateTime)
