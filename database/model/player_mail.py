from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class PlayerMail(Base):
    __tablename__ = 'player_mail'

    mail_id = Column(Text, nullable=False, primary_key=True)
    receiver_id = Column(Text, nullable=False)
    sender_name = Column(Text, default='System')
    subject = Column(Text, nullable=False)
    body = Column(Text)
    attachment_json = Column(JSON)
    is_read = Column(Boolean, default=False)
    is_claimed = Column(Boolean, default=False)
    sent_at = Column(DateTime, server_default=func.now())
    expires_at = Column(DateTime)
