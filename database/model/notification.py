from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class Notification(Base):
    __tablename__ = 'notification'

    notification_id = Column(Text, nullable=False, primary_key=True)
    player_id = Column(Text, nullable=False)
    character_id = Column(Text)
    notification_type = Column(Text, nullable=False)
    title = Column(Text, nullable=False)
    body = Column(Text)
    payload_json = Column(JSON)
    is_read = Column(Boolean, nullable=False, default=False)
    read_at = Column(DateTime)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    expires_at = Column(DateTime)
