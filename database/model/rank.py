from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class Rank(Base):
    __tablename__ = 'rank'

    rank_id = Column(Text, nullable=False, primary_key=True)
    name = Column(Text)
    power_multiplier = Column(Text)
    description = Column(Text)
