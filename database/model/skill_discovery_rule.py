from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class SkillDiscoveryRule(Base):
    __tablename__ = 'skill_discovery_rule'

    skill_id = Column(Text, nullable=False, primary_key=True)
    activity_type = Column(Text, nullable=False)
    base_chance = Column(Text)
    rarity = Column(Text, nullable=False)
    talent_bonus = Column(JSON)
