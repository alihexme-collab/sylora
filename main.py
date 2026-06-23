from receive import *

def main():
    print("در حال شروع...")
    app.run_polling()

if __name__ == "__main__":
    print(bus.listeners)
    main()
    