from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class WorldEnvironment(Base):
    __tablename__ = 'world_environment'

    environment_id = Column(Text, nullable=False, primary_key=True)
    location_id = Column(Text)
    weather_type = Column(Text, nullable=False)
    active_buffs_json = Column(JSON)
    started_at = Column(DateTime, server_default=func.now())
    ends_at = Column(DateTime)
