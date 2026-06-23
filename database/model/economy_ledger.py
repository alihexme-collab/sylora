from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class EconomyLedger(Base):
    __tablename__ = 'economy_ledger'

    ledger_id = Column(Text, nullable=False, primary_key=True)
    wallet_id = Column(Text, nullable=False)
    player_id = Column(Text)
    transaction_type = Column(Text, nullable=False)
    currency_type = Column(Text, nullable=False)
    amount = Column(BigInteger, nullable=False)
    balance_before = Column(BigInteger)
    balance_after = Column(BigInteger)
    source_type = Column(Text)
    source_id = Column(Text)
    note = Column(Text)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
