from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class EnemyInstance(Base):
    __tablename__ = 'enemy_instance'

    instance_id = Column(Text, nullable=False, primary_key=True)
    enemy_id = Column(Text)
    level = Column(Integer)
    hp = Column(Integer)
    mana = Column(Integer)
    location_id = Column(Text)
    extra_properties = Column(Text)
    energy = Column(Integer)
    spawn_at = Column(DateTime)
