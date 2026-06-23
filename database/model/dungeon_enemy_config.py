from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class DungeonEnemyConfig(Base):
    __tablename__ = 'dungeon_enemy_config'

    dungeon_id = Column(Text, nullable=False, primary_key=True)
    enemy_id = Column(Text, nullable=False, primary_key=True)
    min_count = Column(Integer)
    max_count = Column(Integer)
    spawn_weight = Column(Integer)
