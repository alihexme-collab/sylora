# database/db_manager.py
from sqlalchemy.ext.asyncio import create_async_engine, AsyncSession
from sqlalchemy.orm import sessionmaker
from contextlib import asynccontextmanager
import config


# تبدیل URL به پروتکل asyncpg
ASYNC_DB_URL = config.DATABASE_URL.replace("postgresql://", "postgresql+asyncpg://")

engine = create_async_engine(ASYNC_DB_URL, echo=True) # Echo=True باعث میشه کوئری ها رو در کنسول ببینی
AsyncSessionLocal = sessionmaker(engine, expire_on_commit=False, class_=AsyncSession)

@asynccontextmanager
async def get_db():
    async with AsyncSessionLocal() as session:
        try:
            yield session
            await session.commit() # تایید نهایی خودکار
        except Exception:
            await session.rollback() # اگر خطایی بود، برگردون به عقب
            raise
        finally:
            await session.close()
