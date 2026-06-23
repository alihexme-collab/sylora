from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class MarketListing(Base):
    __tablename__ = 'market_listing'

    listing_id = Column(Text, nullable=False, primary_key=True)
    seller_id = Column(Text, nullable=False)
    item_instance_id = Column(Text)
    item_id = Column(Text, nullable=False)
    quantity = Column(Integer, default=1)
    price_per_unit = Column(BigInteger, nullable=False)
    currency_type = Column(Text, default='gold')
    created_at = Column(DateTime, server_default=func.now())
    expires_at = Column(DateTime, nullable=False)
    is_sold = Column(Boolean, default=False)
    is_cancelled = Column(Boolean, default=False)
