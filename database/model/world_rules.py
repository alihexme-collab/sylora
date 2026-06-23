from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class WorldRules(Base):
    __tablename__ = 'world_rules'

    id = Column(Integer, nullable=False, primary_key=True)
    rule_key = Column(String, nullable=False, primary_key=True)
    rule_value = Column(Numeric, nullable=False, primary_key=True)
    affected_location_id = Column(Text)
    affected_civilization_id = Column(Integer)
    expires_at = Column(DateTime)
