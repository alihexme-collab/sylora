from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class PlayerWallet(Base):
    __tablename__ = 'player_wallet'

    wallet_id = Column(Text, nullable=False, primary_key=True)
    player_id = Column(Text, nullable=False, primary_key=True)
    gold_balance = Column(BigInteger, nullable=False, default=0)
    gem_balance = Column(BigInteger, nullable=False, default=0)
    silver_balance = Column(BigInteger, nullable=False, default=0)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    updated_at = Column(DateTime, nullable=False, server_default=func.now())
