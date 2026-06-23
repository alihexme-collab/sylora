from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class WorldLinks(Base):
    __tablename__ = 'world_links'

    id = Column(Integer, nullable=False, primary_key=True)
    source_location_id = Column(Text)
    target_location_id = Column(Text)
    link_type = Column(String, default='portal')
    is_active = Column(Boolean, default=True)
    mana_cost = Column(Integer, default=0)
    meta_data = Column(JSON)
    required_item_id = Column(Text)
