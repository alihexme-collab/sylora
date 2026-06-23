from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class EventHistory(Base):
    __tablename__ = 'event_history'

    player_id = Column(Text)
    event_type = Column(Text)
    event_data = Column(JSON)
    created_at = Column(Text)
    event_id = Column(Text, nullable=False, primary_key=True)
