from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class PlayerSession(Base):
    __tablename__ = 'player_session'

    session_id = Column(Text, nullable=False, primary_key=True)
    player_id = Column(Text, nullable=False, primary_key=True)
    telegram_chat_id = Column(Text)
    ip_address = Column(Text)
    user_agent = Column(Text)
    login_at = Column(DateTime, nullable=False, server_default=func.now())
    last_seen_at = Column(DateTime)
    logout_at = Column(DateTime)
    is_active = Column(Boolean, nullable=False, default=True)
    refresh_token_hash = Column(Text)
