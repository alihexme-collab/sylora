from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class WorldObjects(Base):
    __tablename__ = 'world_objects'

    id = Column(Integer, nullable=False, primary_key=True)
    location_id = Column(Text)
    object_type = Column(String, nullable=False)
    state = Column(JSON)
    interaction_logic = Column(String)
    last_interacted_at = Column(DateTime)
    respawn_time_seconds = Column(Integer)
