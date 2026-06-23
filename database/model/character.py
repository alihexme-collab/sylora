from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class Character(Base):
    __tablename__ = "character"

    character_id = Column(Text, primary_key=True)
    player_id = Column(Text)
    name, race, rank_id = Column(Text), Column(Text), Column(Text)
    created_at = Column(DateTime)
    character_path = Column(Text)
    age = Column(Integer)
    is_alive=Column(Boolean)