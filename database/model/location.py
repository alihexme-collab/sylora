from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class Location(Base):
    __tablename__ = 'location'

    location_id = Column(Text, nullable=False, primary_key=True)
    name = Column(Text)
    danger_level = Column(Integer)
    region_type = Column(Text)
    description = Column(Text)
