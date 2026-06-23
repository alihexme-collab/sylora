from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class Clan(Base):
    __tablename__ = 'clan'

    clan_id = Column(Text, nullable=False, primary_key=True)
    name = Column(Text, nullable=False)
    leader_character_id = Column(Text, nullable=False)
    description = Column(Text)
    created_at = Column(DateTime, nullable=False, server_default=func.now())
    updated_at = Column(DateTime, nullable=False, server_default=func.now())
    is_active = Column(Boolean, nullable=False, default=True)
