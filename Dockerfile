# --- build ---
FROM python:3.12-alpine AS build

WORKDIR /app

RUN apk add --no-cache build-base

COPY requirements.txt .

RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

COPY . .

# --- runtime ---
FROM python:3.12-alpine

WORKDIR /app

COPY --from=build /install /usr/local
COPY --from=build /app /app

ENV PYTHONUNBUFFERED=1

EXPOSE 5000

CMD ["python", "app.py"]
