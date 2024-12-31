import typer

from .log_analyzer import analyze


app = typer.Typer()
app.command()(analyze)


if __name__ == "__main__":
    app()