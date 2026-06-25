from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class Player(Base):
    __tablename__ = 'player'

    player_id = Column(Text, nullable=False, primary_key=True)
    telegram_id = Column(BigInteger)
    username = Column(Text)
    created_at = Column(DateTime)
    last_active = Column(DateTime)
    role = Column(Text)
    is_banned = Column(Boolean)
