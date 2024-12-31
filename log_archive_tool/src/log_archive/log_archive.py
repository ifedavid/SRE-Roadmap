import typer
import os
from datetime import datetime
from pathlib import Path
import subprocess
from typing_extensions import Optional

HOME_DIRECTORY = os.environ.get("HOME")


def archive(log_path: Optional[str] = typer.Argument(default=None)):
    if not log_path:
        log_path = typer.prompt("Please enter the path to the log file to archive")

    log_path = Path(log_path)
    if not log_path.is_dir():
        raise typer.BadParameter("The path to the log file must be a directory")

    typer.echo(f"Analyzing logs at {log_path}")
    log_files = subprocess.run(
        f"find {log_path} -type f -name '*.log'",
        shell=True,
        capture_output=True,
        text=True,
    )

    if not log_files.stdout:
        raise typer.BadParameter(
            "No log files found in the specified directory", log_files.stderr
        )

    typer.echo(f"Found log files: {log_files.stdout}")
    log_files_format = log_files.stdout.replace("\n", " ")

    typer.echo("Archiving logs...")

    Path(f"{HOME_DIRECTORY}/archived_logs").mkdir(exist_ok=True)
    result = subprocess.run(
        f"tar -czvf {HOME_DIRECTORY}/archived_logs/log_archive.{datetime.now().strftime('%Y%m%d_%H%M%S')}.tar.gz {log_files_format}",
        shell=True,
        capture_output=True,
        text=True,
        env=os.environ,
    )

    if result.returncode != 0:
        typer.echo(f"Failed to archive logs: {result.stderr}", err=True)
        typer.Exit(code=result.returncode)
    else:
        print(result.stdout)
        print(f"Logs archived at {HOME_DIRECTORY}/archived_logs")
        print("Archiving complete!")
