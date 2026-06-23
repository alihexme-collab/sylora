from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class Achievement(Base):
    __tablename__ = 'achievement'

    achievement_id = Column(Text, nullable=False, primary_key=True)
    code = Column(Text, nullable=False)
    name = Column(Text, nullable=False)
    description = Column(Text)
    category = Column(Text)
    rarity = Column(Text)
    reward_json = Column(JSON)
    is_hidden = Column(Boolean, nullable=False, default=False)
    created_at = Column(DateTime, nullable=False)
