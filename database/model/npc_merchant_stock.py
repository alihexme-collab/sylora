from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric, Interval
from sqlalchemy.orm import relationship
from .base import Base

class NpcMerchantStock(Base):
    __tablename__ = 'npc_merchant_stock'

    npc_id = Column(Text, nullable=False, primary_key=True)
    item_id = Column(Text, nullable=False, primary_key=True)
    price = Column(BigInteger, nullable=False, primary_key=True)
    currency_type = Column(Text, default='gold')
    stock_quantity = Column(Integer, default='-1')
    refresh_time = Column(Interval)
