from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class Guild(Base):
    __tablename__ = 'guild'

    guild_id = Column(Text, nullable=False, primary_key=True)
    name = Column(Text, nullable=False)
    leader_character_id = Column(Text, nullable=False)
    description = Column(Text)
    motto = Column(Text)
    level = Column(Integer, nullable=False, default=1)
    exp = Column(BigInteger, nullable=False, default=0)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    updated_at = Column(DateTime, nullable=False, server_default=func.now())
    is_active = Column(Boolean, nullable=False, default=True)
