from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class PlayerState(Base):
    __tablename__ = 'player_state'

    player_id = Column(Text, primary_key=True)
    current_location_id = Column(Text)
    current_region_id = Column(Text)
    energy = Column(Integer)
    step_counter = Column(Integer)
    last_event_type = Column(Text)
    seed_value = Column(Integer)
    last_location_change = Column(Text)
    last_event_at = Column(DateTime)
