from sqlalchemy import Column, Integer, String, Text, Boolean, DateTime, JSON, ForeignKey, func, BigInteger, Numeric
from sqlalchemy.orm import relationship
from .base import Base

class NpcInteractionRule(Base):
    __tablename__ = 'npc_interaction_rule'

    rule_id = Column(Text, nullable=False, primary_key=True)
    npc_id = Column(Text, nullable=False, primary_key=True)
    required_quest_id = Column(Text)
    required_level = Column(Integer)
    trigger_event = Column(Text)
    response_text = Column(Text)
    reward_json = Column(JSON)
