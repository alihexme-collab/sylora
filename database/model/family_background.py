from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class FamilyBackground(Base):
    __tablename__ = 'family_background'

    background_id = Column(Text, nullable=False, primary_key=True)
    name = Column(Text)
    description = Column(Text)
    starting_items = Column(JSON)
    start_skill = Column(JSON)
    spawn_weight = Column(Integer)
