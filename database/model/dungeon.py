from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class Dungeon(Base):
    __tablename__ = 'dungeon'

    dungeon_id = Column(Text, nullable=False, primary_key=True)
    name = Column(Text)
    location_id = Column(Text)
    description = Column(Text)
