run-native: build-native
	@docker-compose up reactive-quarkus-db reactive-quarkus-app-native
	@echo "running at port 8080"

run-jvm: build-jvm
	@docker-compose up reactive-quarkus-db reactive-quarkus-app-jvm
	@echo "running at the port 8081"

run-db:
	@docker-compose up -d reactive-quarkus-db

package-jvm-only:
	@./mvnw package -DskipTests=true

package-native:
	@./mvnw package -DskipTests=true -Pnative

build-native: package-native
	@docker build -f src/main/docker/Dockerfile.native -t somebodythatiusedtoknow/reactive-quarkus-native .

build-jvm: package-jvm-only
	@docker build -f src/main/docker/Dockerfile.jvm -t somebodythatiusedtoknow/reactive-quarkus-jvm .
