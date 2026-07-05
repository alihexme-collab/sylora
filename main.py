from receive import *

def main():
    print("=== BUILD VERSION: 2026-07-05-v1 ===")

    print("در حال شروع...")
    app.run_polling()

if __name__ == "__main__":
    print(bus.listeners)
    main()
    