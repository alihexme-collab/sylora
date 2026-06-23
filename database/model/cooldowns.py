from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class Cooldowns(Base):
    __tablename__ = 'cooldowns'

    cooldown_id = Column(Text, nullable=False, primary_key=True)
    character_id = Column(Text, nullable=False)
    skill_id = Column(Text)
    action_type = Column(Text, nullable=False)
    target_id = Column(Text)
    started_at = Column(DateTime, nullable=False, server_default=func.now())
    ends_at = Column(DateTime, nullable=False)
    is_active = Column(Boolean, nullable=False, default=True)
    metadata_json = Column(JSON)
