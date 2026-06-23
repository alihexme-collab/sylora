from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class LoginHistory(Base):
    __tablename__ = 'login_history'

    login_history_id = Column(Text, nullable=False, primary_key=True)
    player_id = Column(Text, nullable=False)
    session_id = Column(Text)
    login_at = Column(DateTime, nullable=False, server_default=func.now())
    logout_at = Column(DateTime)
    ip_address = Column(Text)
    user_agent = Column(Text)
    login_status = Column(Text, nullable=False, default='success')
    failure_reason = Column(Text)
