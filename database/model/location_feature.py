from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class LocationFeature(Base):
    __tablename__ = 'location_feature'

    feature_id = Column(Text, nullable=False, primary_key=True)
    location_id = Column(Text, primary_key=True)
    name = Column(Text)
    rarity = Column(Text)
    effect_json = Column(JSON)
    effect_region = Column(Text)
    weight = Column(Integer)
