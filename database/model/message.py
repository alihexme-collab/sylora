from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class Message(Base):
    __tablename__ = 'message'

    message_id = Column(Text, nullable=False, primary_key=True)
    sender_player_id = Column(Text)
    receiver_player_id = Column(Text)
    sender_character_id = Column(Text)
    receiver_character_id = Column(Text)
    subject = Column(Text)
    body = Column(Text)
    attachment_json = Column(JSON)
    status = Column(Text, nullable=False, default='sent')
    sent_at = Column(DateTime, nullable=False, server_default=func.now())
    read_at = Column(DateTime)
