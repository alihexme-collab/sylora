from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class Npc(Base):
    __tablename__ = 'npc'

    npc_id = Column(Text, nullable=False, primary_key=True)
    name = Column(Text, nullable=False)
    title = Column(Text)
    npc_type = Column(Text, nullable=False)
    description = Column(Text)
    base_location_id = Column(Text)
    is_killable = Column(Boolean, default=False)
    dialogue_json = Column(JSON)
    extra_properties = Column(JSON)
