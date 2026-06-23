from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class PartyMember(Base):
    __tablename__ = 'party_member'

    party_id = Column(Text, nullable=False, primary_key=True)
    character_id = Column(Text, nullable=False, primary_key=True)
    member_role = Column(Text, nullable=False, default='member')
    joined_at = Column(DateTime, nullable=False, server_default=func.now())
    left_at = Column(DateTime)
    is_active = Column(Boolean, nullable=False, default=True)
