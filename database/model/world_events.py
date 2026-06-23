from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class WorldEvents(Base):
    __tablename__ = 'world_events'

    id = Column(Text, nullable=False, primary_key=True)
    event_type = Column(String)
    description = Column(String)
    created_at = Column(DateTime)
