from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class Civilizations(Base):
    __tablename__ = 'civilizations'

    id = Column(Integer, nullable=False, primary_key=True)
    slug = Column(String, nullable=False)
    name = Column(String, nullable=False)
    description = Column(Text)
    starting_stats_bonus = Column(JSON, default='{}')
    culture_type = Column(String)
    created_at = Column(DateTime, default=func.now())
    starting_location_id = Column(Text)
