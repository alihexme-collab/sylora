from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class Quest(Base):
    __tablename__ = 'quest'

    quest_id = Column(Text, nullable=False, primary_key=True)
    name = Column(Text)
    location_id = Column(Text)
    difficulty_rank = Column(Text)
    reward_json = Column(JSON)
    description = Column(Text)
